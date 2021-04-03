require_relative '../lib/atm.rb'
require_relative '../lib/person.rb'

describe Person do
    
    subject { described_class.new(name:'Dav')}

    it 'is expected to have :name on init' do
        expect(subject.name).not_to be nil
    end

    it 'is expected to rise an error if no name is set' do
        expect {subject.name_error}. to raise_error 'A name is required'
    end

    it 'is expected to have a :cash attr with the value of 0 on init' do
        expect(subject.cash).to eq 0
    end

    it 'is expected to have a :account attr' do
        expect(subject.account).to be nil
    end

    describe 'can create an Account' do
        before {subject.create_account}

        it 'of Account class' do
            expect(subject.account).to be_an_instance_of Account
        end
        
        it 'with himself as an owner' do
            expect(subject.account.owner).to be subject
            
        end

    end

    describe 'can make funds if an account is created' do
        let(:atm) {Atm.new}
        before {subject.create_account}
        it 'can deposit funds' do
            expect(subject.deposit(100)).to be_truthy
        end

        

        it 'funds are added to the account balance - deducted from cash' do
            subject.cash = 100
            subject.deposit(100)
            expect(subject.account.balance).to be 100
            expect(subject.cash).to be 0
        end

        it 'can withdraw funds' do
            command = lambda {subject.withdraw(amount: 100, pin: subject.account.pin_code, account: subject.account, atm: Atm)}
            expect(command.call).to be_truthy
        end

        it 'withdraw is expectedto raise an error if no ATM is passed in' do
            command = lambda {subject.withdraw(amount: 100, pin: subject.account.pin_code, account: subject.account)}
            expect(command.call).to raise_error 'ATM required'
        end

        
    end
    describe 'can not manage funds if no account been created' do
            it 'can/`t deposit funds ' do
                expect{subject.deposit(100)}.to raise_error(RuntimeError, 'No account present')
            end
        end
end
