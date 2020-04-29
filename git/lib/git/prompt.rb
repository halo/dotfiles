module Git
  module Prompt
    def self.error(message)
      $stderr.puts stylize :red, message
    end

    def self.stylize(style, message)
      start_code = case style
                   when :normal    then 0
                   when :red       then 31
                   when :green     then 32
                   when :yellow    then 33
                   when :blue      then 34
                   when :magenta   then 35
                   when :cyan      then 36
                   when :bold      then 1
                   end

      end_code = case style
                 when :blink then 25
                 when :bold  then 22
                 else 0
                 end

      %(\033[#{start_code}m#{message}\033[#{end_code}m)
    end

  end
end
