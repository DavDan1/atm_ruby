class Atm
    attr_accessor :funds

    def initialize(attributes)
        self.funds= attributes[:initial_funds]
    end

    def withdraw(attrs)
        account=attrs[:account]
        amount=attrs[:amount]
        if (account.balance > amount)
            self.funds -= amount
            binding.pry
            account.balance = account.balance - amount
        else
            {status: 'error',message:'you cant do this!'}
      end
    end 
end
    def initialize
        @funds = 1000
    end

    def withdraw(amount, pin_code, account, account_status) 
        
        case 
        when insufficient_funds_in_account?(amount, account)
            {status: false, message: 'insufficient funds in account',date: Date.today}
        when insufficient_funds_in_atm?(amount)
            {status: false, message: 'insuffisient funds in ATM',date: Date.today} 
        when incorrect_pin?(pin_code, account.pin_code)
            {status: false, message: 'wrong pin',date: Date.today}
        when card_expired?(account. exp_date)
            {status: false, message: 'card expired',date: Date.today}
            
        when disabled_account?(account_status)
            {status: false, message: 'disabled account', date: Date.today}
            
        else
            perform_transaction(amount, account)
            
        end
    end

    private

    def insufficient_funds_in_account?(amount, account)
        amount > account.balance
    end
    

    def perform_transaction(amount, account)
        @funds -= amount
        account.balance = account.balance - amount
        { status: true , message: 'success', amount: amount,date: Date.today,bills: add_cash(amount)}
    end
    def insufficient_funds_in_atm?(amount)
        @funds < amount
        
    end
    def incorrect_pin?(pin_code, actual_pin)
        pin_code != actual_pin
        
    end
    def disabled_account?(account_status)
        account_status == (:disabled)
        
    end
    def card_expired?(exp_date)
        Date.strptime(exp_date, '%m/%y') < Date.today
         
    end
    def add_cash(amount)
        cash=[50,20,10,5]
        bills=[]
        amount=120
        cash.each do |bill|
            while amount-bill>=0
                amount -= bill
                bills<<bill
            end
            bills
        
            end
    end

    
end

