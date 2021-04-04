require_relative '../lib/atm.rb'
require 'date'

describe Atm do
    let(:account){instance_double('Account', pin_code: '1234', exp_date: '04/22', account_status: :active)}
    before do
        allow(account).to receive(:balance).and_return(100)
        allow(account).to receive(:balance=)
    end
    it 'has 1000 on initialize' do
        expect(subject.funds).to eq 1000
    end
    
    it 'funds are reduced at withdraw' do
    subject.withdraw(50, '1234', account, :active)
    expect(subject.funds).to eq 950

    end
    it 'allow withdraw if the account has enough balance.' do
        
        expected_output = { status:true, message: 'success',amount: 45,date: Date.today, bills: [50,20,10,5]} 
        expect(subject.withdraw(45,'1234', account, :active)).to eq expected_output
        
    end
    
    it 'reject withdraw if account has insufficient funds' do
        expected_output= {status: false, message:  'insufficient funds in account', date: Date.today}
        expect(subject.withdraw(105,'1234', account, :active)).to eq expected_output
    end
    it 'reject withdraw if ATM has insufficient funds' do
        subject.funds = 50
        expected_output = {status: false, message: 'insuffisient funds in ATM', date: Date.today}
        expect(subject.withdraw(100, '1234',account, :active)).to eq expected_output
    end
    it 'reject withdraw if pin is wrong' do
        expected_output={status: false, message: 'wrong pin', date: Date.today}
        expect(subject.withdraw(50,9999, account, :active)).to eq expected_output
    end
    it 'reject the withdraw if the card is expired' do
        allow(account).to receive(:exp_date).and_return('04/20')
        expected_output = {status: false, message: 'card expired',date: Date.today}
        expect(subject.withdraw(6, '1234', account, :active)).to eq expected_output
    end
    
    it 'account is disabled' do
        expected_output={status: false, message: 'disabled account',date: Date.today}
        expect(subject.withdraw(6,'1234', account, :disabled)).to eq expected_output
    end

    
    

end
# work in progress






