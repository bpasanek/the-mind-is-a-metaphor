module ActiveRecord
  module Validations

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      # Validates whether the value of the specified attribute is a valid
      # string representation of a date (by trying to convert it to a
      # date using <tt>Date.parse</tt>). This method is analogous to the
      # standard <tt>validates_numericality_of</tt> method for validating
      # a string representation of a number.
      #
      # <b>Options</b>
      #
      # * +from+ -- Minimum allowed date
      # * +to+ -- Maximum allowed date
      # These values can be either a date or a string representation of a
      # date (as recognized by <tt>Date.parse</tt>).
      #
      # <b>Example</b>
      #
      #   class Person < ActiveRecord::Base
      #     require_dependency 'validates_date_of'
      #     validates_date_of :birthday,
      #                       :from => '1 Jan 1920',
      #                       :to => Date.today,
      #                       :allow_nil => true
      #   end
      #
      # <b>Acknowledgement</b>
      #
      # This code was modeled in part on the
      # <tt>validates_numericality_of</tt> method in Rails, and in part
      # on this code snippet: http://snippets.dzone.com/posts/show/1548
      #
      # <b>Note</b>
      #
      # <tt>validates_date_of</tt> has no effect when using
      # the Rails-generated <select> elements for dates. The Rails
      # <select> elements allow selecting an invalid date, such as
      # 31 Feb 2007. But if the MySQL column is DATETIME, the record
      # still gets saved successfully, with a date of 3 Mar 2007. (And if
      # the MySQL column is DATE, you get a Ruby error of type
      # ActiveRecord::MultiparameterAssignmentErrors before validation
      # even happens.) This self-correcting date behavior is either a
      # feature or a bug in Rails.
      #
      # However, when using input controls other than the Rails <select>
      # elements for dates (such as a regular <input type="text"> field
      # combined with a JavaScript calendar picker), then
      # <tt>validates_date_of</tt> is very useful.

      def validates_date_of(*attr_names)
        configuration = { :message => 'is not a valid date',
                          :on => :save,
                          :allow_nil => false }
        configuration.update(attr_names.pop) if attr_names.last.is_a?(Hash)
        validates_each(attr_names, configuration) do |record, attr_name, value|
          next if configuration[:allow_nil] and record.send("#{attr_name}_before_type_cast").blank?
          begin
            date = Date.parse(record.send("#{attr_name}_before_type_cast").to_s, true)  # true means supply century for 2-digit years, using 19XX  if >= 69 or 20XX if < 69
          rescue ArgumentError
            record.errors.add(attr_name, configuration[:message])
          else
            if configuration[:from]
              from = Date.parse(configuration[:from].to_s)
              if date < from
                record.errors.add(attr_name, "cannot be less than #{from.strftime('%e-%b-%Y')}")
              end
            end
            if configuration[:to]
              to = Date.parse(configuration[:to].to_s)
              if date > to
                record.errors.add(attr_name, "cannot be greater than #{to.strftime('%e-%b-%Y')}")
              end
            end
          end
        end
      end

    end
  end
end
