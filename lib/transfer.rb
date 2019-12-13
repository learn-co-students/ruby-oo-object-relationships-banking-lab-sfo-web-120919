require 'pry'

class Transfer
  attr_accessor :sender, :receiver, :status, :amount

  def initialize(sender, receiver, status="pending", amount)
    @sender = sender
    @receiver = receiver
    @status = status
    @amount = amount
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if @sender.balance < @amount || @sender.status == 'closed' || @receiver.status == 'closed'
      @status = 'rejected'
      return "Transaction rejected. Please check your account balance."

    elsif @status == 'complete'
      puts "Transaction was already executed"

    else 
      @sender.balance -= @amount
      @receiver.balance += @amount
      @status = 'complete'
     end
  end

  def reverse_transfer
    if @status == 'complete'
      # execute_transaction.undef_method
      @sender.balance += @amount
      @receiver.balance -= @amount
      @status = 'reversed'

    end

  end



end
