# typed: ignore
# frozen_string_literal: true

require "open3"
require "sorbet-runtime"

class BenchmarkToDocument < T::Struct
  const(:path, String)
  const(:description, String)
end

BENCHMARKS_TO_DOCUMENT = [
  BenchmarkToDocument.new(path: "execute", description: "Parse + Execute"),
]

namespace :bench do
  all_tasks = [:compile]

  Dir.glob("bench/*.rb").each do |path|
    task_name = File.basename(path, ".rb")
    next if task_name == "bench" # Bench helper

    desc "Run #{path} benchmark"
    task task_name do
      sh "ruby -Ilib #{path}"
      puts
    end

    all_tasks << task_name
  end

  desc "Run all benchmarks"
  task all: all_tasks

  desc "Document benchmark results"
  task :doc do
    output = ""

    BENCHMARKS_TO_DOCUMENT.each do |benchmark|
      puts "Benchmarking #{benchmark.path}"
      [true, false].each do |yjit|
        env = yjit ? { "RUBY_YJIT_ENABLE" => "1" } : {}
        stdout, status = Open3.capture2e(env, "ruby", "-Ilib", "bench/#{benchmark.path}.rb")
        unless status.success?
          abort("Encountered an error: #{stdout}")
        end
        padded_stdout = stdout.lines.map { |line| "  #{line.chomp}".tap(&:rstrip!) }.join("\n")
        output += <<~END
          <details>
            <summary>#{benchmark.description} (Ruby 3.2, YJIT #{yjit ? "enabled" : "disabled"})</summary>

            ```
          #{padded_stdout}
            ```
          </details>
        END
        output += "\n"
      end
    end

    readme = "README.md"
    contents = File.read(readme)
    pattern = /(?<=<!---benchmark result start-->\n).*?(?=<!---benchmark result end-->)/m
    File.write(readme, contents.gsub!(pattern, output.chomp))
  end
end

desc "Run all benchmarks"
task bench: "bench:all"
