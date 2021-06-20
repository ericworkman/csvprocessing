module Validators
  class << self

    def exists?(field)
      !field.nil? &&
        field.length > 0
    end

    def phone_number?(raw)
      return false if raw.nil?
      field = raw.tr('^0-9', '')

      field.length == 11 &&
        field.start_with?('1') &&
        raw.start_with?('+1')
    end

    # Assumes ISO8601 date
    def date?(field)
      exists?(field) &&
        !field.match(/\d{4}\-\d{2}\-\d{2}/).nil?
    end

  end
end
