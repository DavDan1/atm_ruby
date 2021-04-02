class Account 
    attr_accessor :exp_date, :account_status, :balance
    attr_reader :pin_code, :customer

    STANDARD_VALIDILITY_YRS = 5 #why is it capital letters?

    def initialize(attrs = {})
        @exp_date = '04/26'
        @pin_code = rand(1000..9999)
        @account_status = :active
        @balance = 0 
        set_customer(attrs[:customer])
    end
    
    def set_expire_date
        Date.today.next_year(STANDARD_VALIDILITY_YRS).strftime('%m/%y')
    end
    
    

    def  deactivate
        @account_status = :deactivated
    end

    end


    private

    def set_customer(object)
        object == nil ? missing_customer : @customer = object
    end

    def missing_customer
        raise "An account customer is required"
    end

