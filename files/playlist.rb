#! /usr/bin/env ruby
require 'yaml'
require 'watir-webdriver'
require 'test/unit'
require 'mysql2'
require 'trollop'
require 'httparty_with_cookies'
require 'json'
require 'json-schema'
require 'hashdiff'
require 'thread'
require 'rest-client'



include Test::Unit::Assertions


def self.playlist

  def self.reqGlobals(configfile)
    begin
        if (File.exist? (configfile)) == true then
          config_ = YAML.load_file("#{configfile}")
          if (config_.has_key? ("global")) == true
            return config_["global"]
          else
            puts "\e[1;31m Unable to find global: in config.yaml file."
            exit
          end
        end
    rescue => e
          puts e
    end
  end

pathHere = Dir.pwd
$configFile = "#{pathHere}/config.yaml"
$global = reqGlobals($configFile)

$path = $global["path"]
pathHere = "#{pathHere}/#{$path}"
lib = "#{pathHere}/lib"
Dir["#{lib}/*.rb"].each {|file| require file }

$mysqlClient = "none"
$envName = "default"
$skipArray = Array.new
@command = "none"
$testArray = Array.new
$testSuiteArray = Array.new
$erroLine = "none"
$errorId = "none"
$currentTestName = "NA"
$envName = Array.new
$srcPath = "none"


$dataDir = Path.dataDirectoryPath(pathHere)
$pageObjDir = Path.pageObjectPath(pathHere)
$testDir = Path.testPath(pathHere)
$srcPath = Path.srcPath(pathHere)



opts = Trollop::options do
  opt :e, "To execute all tests cases run ./nightowl you may provide environent using -e <envName>", :type => :string
  opt :s, "To execute test suite run ./nightowl -s <testSuite1Path> <testSuite2Path> <testSuiteNpath>"
  opt :skip, "To skip tests run ./nightowl --skip <justTestName1> <justTestName2> <justTestName3>"
  opt :t, "To execute tests run ./nightowl -t <test1Path> <test2Path> <testNpath>"
  opt :help, "help"
end

if (opts.has_key? (:e_given)) == true then
    if (opts[:e].include? (",")) == true then
      $envName = opts[:e].split(",")
    else
      $envName.push(opts[:e])
    end
else
  $envName.push("default")
end


if (opts[:skip] || opts[:t] || opts[:s]) != true then
      @command = "all"
elsif (opts.has_key? (:skip_given)) == true then
        ((ARGV.inspect).gsub(/\"/, "").gsub(/[\[\]]/, "")).split(",").each do |earchArg|
          $skipArray.push(earchArg)
        end
      @command = "skip"
elsif (opts.has_key? (:t_given)) == true then
        ((ARGV.inspect).gsub(/\"/, "").gsub(/[\[\]]/, "")).split(",").each do |earchArg|
            $testArray.push(earchArg)
         end
      @command = "run"
elsif (opts.has_key? (:s_given)) == true then
        ((ARGV.inspect).gsub(/\"/, "").gsub(/[\[\]]/, "")).split(",").each do |earchArg|
            $testSuiteArray.push(earchArg)
          end
      @command = "folder"
end


$envName.each do |env|
  $env = env

Req.req_config($configFile, $env)

case @command
    when "all"
      All.all
    when "skip"
      Skip.skip
    when "run"
      Run.run
    when "folder"
      Folder.folder
 end
end

end
