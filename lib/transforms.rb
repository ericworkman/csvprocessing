require 'date'

module Transforms
  class << self

    # Coerce a field into a US phone number if it looks like it could be a US phone number
    # US phone numbers in E.164 -> "+1" + 10 digits.
    # E.164 supports 15 digits, but US will be less
    def phone_number(field)
      return if field.nil?

      possible = field.tr('^0-9', '')

      if possible.length == 10
        "+1#{possible}"
      elsif possible.length == 11 && possible.start_with?("1")
        "+#{possible}"
      else
        field
      end
    end

    # Coerce a field into an ISO8601 date if it looks like a date
    # Shorthand year is a problem.
    # Logically, it makes sense to assume recent years not early first century in this context.
    # TIL POSIX standard on short year is 69-99 -> 19xx, 0-68 -> 20xx
    def date(field)
      return if field.nil?

      possible = field.tr('\/\-', '-')
      begin
        viable_date = Date.strptime(possible, '%m-%d-%y')
        viable_date.iso8601
      rescue Date::Error
        field
      end
    end

  end
end
