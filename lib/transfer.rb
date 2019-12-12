require 'pry'


class Transfer

  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  @@all = []

  def initialize(sender, receiver, amount)
    @sender = sender 
    @receiver = receiver 
    @amount = amount 
    @status = "pending"
    @@all << self 
    #binding.pry
  end

  def self.all
    @@all
  end 

  def has_transaction?
     # iterate through all of the Transaction instances in Transaction.all
     Transfer.all.each do |t|
       # check to see if the transaction has taken place
      # binding.pry
       if (t.receiver == @receiver && t.sender == @sender) && (@status != "complete")
         return true
      end 
    end
      return false
  end 
  def has_funds?
    @sender.balance >= @amount
  end
  def valid?
      sender.valid? && receiver.valid?
  end 

  def execute_transaction
     if valid? && has_transaction?
      #binding.pry
       if !has_funds?
         #binding.pry
         @status = "rejected"
         return "Transaction rejected. Please check your account balance."
       end 
       #binding.pry
       @sender.balance -= @amount
       @receiver.deposit(@amount)
       @status = "complete"
       # returning here
      else
        @status = "rejected"
        return "Transaction rejected. Please check your account balance."
     end 
     
     end 
 
     def reverse_transfer
         if @status == "complete"
           # reverse transfer
           @sender.deposit(@amount)
           @receiver.balance -= @amount
           @status = "reversed"
         end 
     end 


end
