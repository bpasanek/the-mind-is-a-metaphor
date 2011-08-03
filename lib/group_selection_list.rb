# Subclass used to populate grouped selection lists
  class GroupSelectionList
    
    # structure for storing value/option pairs for a selection list
    ValueOption = Struct.new(:id, :name)
    
    # class used to hold the grouped selection list to be used in the generation of a selection list
    class GroupedValues
      attr_reader :grouping, :options
      def initialize(group)
        @grouping = group
        @options = []
      end
      def <<(option)
        @options << option
      end
    end
    
    attr_reader :select_list
    
    def initialize(class_name)
      select_list = []
      # retrieve the grouping values from the table/class
      sorted_groupings = class_name.constantize.count(:name, :group => 'grouping', :order => 'grouping ASC')
      
      # loop through the grouping values... 
      sorted_groupings.each do |group, cnt|
        # create a selection list group for the grouping value...
        new_group = GroupedValues.new(group)
        # and get the list of names associated with the grouping...
        sorted_values = class_name.constantize.find_all_by_grouping(group, :order => 'name ASC')
        # go through the list of grouping names and create a selection list option for it
        sorted_values.each do |record|
          new_group << ValueOption.new(record.id, record.name)
        end
        select_list << new_group
      end
      
      # return the selection list when creating a new instance of this group selection listing class
      @select_list = select_list
    end

 end