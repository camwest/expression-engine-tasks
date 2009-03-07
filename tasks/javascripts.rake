ROOT     = "#{File.expand_path(File.dirname(__FILE__))}/../../../../"
LIB_FOLDER = "#{File.dirname(__FILE__)}/../lib"
JAVASCRIPT_DIR = File.join(ROOT, 'public/javascripts')
JAVASCRIPT_SRC_DIR  = File.join(JAVASCRIPT_DIR, 'src')

load("#{LIB_FOLDER}/protodoc.rb")

COMPRESS_COMMAND = "java -jar #{LIB_FOLDER}/custom_rhino.jar -c #{JAVASCRIPT_DIR}/production.js > #{JAVASCRIPT_DIR}/production_compressed.js 2>&1"

namespace :ee do 
  desc "Combines all javascripts referenced in public/javascripts/src/production.js into public/javascripts/production.js"
  task :combine_javascripts do
    puts "Combining javascripts…"
    Dir.chdir(JAVASCRIPT_SRC_DIR) do
      File.open(File.join(JAVASCRIPT_DIR, 'production.js'), 'w+') do |dist|
        dist << Protodoc::Preprocessor.new('production.js')
      end
    end
    
    puts "Compressing javascripts…"
    system(COMPRESS_COMMAND)
  end
end