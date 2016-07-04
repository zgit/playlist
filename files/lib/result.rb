class Result

   def self.suiteName(name)
     fDir = File.dirname(name)
     return File.basename(fDir)
   end

   def self.suite(name)
     dashLength = (name.length) + 14
     dashLength = "=" * dashLength
     puts "\n"
     puts "\e[1;36m [#{name}] Test Suite: \e[0m"
     print "\e[1;35m #{dashLength} \e[0m"
   end

   def self.testCaseName(name)
     puts "\n"
     puts "\e[1m Running: \e[1;34m[#{name}] \e[0m"
     puts "\e[1m ENV: \e[1;34m#{$env} \e[0m"
     puts "\n"
   end

   def self.startTimer
     return Time.now()
   end

   def self.stopTimer
     return Time.now()
   end

   def self.time(startTime, endTime)
     totalTime = endTime - startTime
     return Time.at(totalTime).utc.strftime("\e[1;34m%M \e[0mmins. & \e[1;34m%S \e[0mseconds")
   end

   def self.failed(message)
     puts "\n"
     puts "\n"
     print "\e[41m FAILED! \e[0m"
     puts "\e[31m #{message} \e[0m"
    #  puts "\n"
     subPath = Dir.pwd
     errorId = $errorId.sub("#{subPath}","")
     char = utfChar("\u2715")
     puts "          \e[31m#{char} \e[0m\e[1m File: \e[31m#{errorId} \e[0m\e[1m Method: \e[31m#{$method} \e[0m\e[1mline#: \e[31m#{$erroLine} \e[0m"
   end

   def self.utfChar(char)
     checkmark = "#{char}"
     return checkmark.encode('utf-8')
   end

   def self.pass(time)
     char = utfChar("\u2713")
     thumbChar = utfChar("\u{1F44D}")
     puts "\n"
     puts "#{thumbChar}   \e[1m( #{time} )"
     puts "\n"
   end

   def self.tearDown
     if ($browser.nil? == false)
           $browser.quit
     end
   end

   def self.stopTrace
     set_trace_func(nil)
   end

   def self.tracer
      char = utfChar("\u2713")
      classname1 = "isnotclass"
      method = "isnotmethod"
    set_trace_func proc { |event, file, line, id, binding, classname|
        if classname == Exception then
            $erroLine = line
            $errorId = file

        end

          if $method != nil then
            if $method == id then
              if event == "return" then
                if classname != classname1
                    classname2 = classname.to_s
                  if (classname2.include? ("::")) == false then
                    classname1 = classname
                    puts "\e[1;35m#{classname} \e[0m"
                  end
                end
                if $method != method
                  method = $method
                  puts "  \e[1;32m#{char} \e[0m \e[0m\e[1m.\e[1;34m#{$method} \e[0m"
                end
             end
           end
         end
    }
  end

end
