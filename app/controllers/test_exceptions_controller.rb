class TestExceptionsController < ApplicationController
  def show
    raise "This is only a test of the exception notification system.  It is a benign exception, only for testing!"
  end
end
