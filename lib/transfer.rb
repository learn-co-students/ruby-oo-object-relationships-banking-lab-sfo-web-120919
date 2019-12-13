class Transfer
  # your code here
  attr_accessor :amount, :sender, :receiver, :status
  
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
  end

  def valid?
      if @sender.valid? && @receiver.valid?
        true
      else
        false
      end
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
      @sender.balance += @amount
      @receiver.balance -= @amount
      @status = 'reversed'
    end
  end
end