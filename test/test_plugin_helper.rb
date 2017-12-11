# This calls the main test_helper in Foreman-core
require 'test_helper'

class Object
  def get_chained_attr_val(attrs)
    attr_val = nil
    attrs.split('.').each_with_index do |method, index|
      attr_val = index.eql?(0) ? try(method) : attr_val.try(method)
    end
    attr_val
  end
end
