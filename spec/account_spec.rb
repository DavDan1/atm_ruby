require_relative '../lib/account.rb'

describe Account do
    let(:user) {instance_double('user', name: 'Dav')}
    subject {described_class.new({customer: user})}
    
    
    it 'it is expected to have an expiry date on initialize' do
    expected_date = Date.today.next_year(5).strftime("%m/%y")
    expect(subject.exp_date).to eq expected_date
    end
    
    it 'is expected to have :active status on initialize' do
    expect(subject.account_status).to eq :active
    end
    
    
    it 'check the length of the number'do
    number = (subject.pin_code)
    number_length = Math.log10(number).to_i + 1
    expect(number_length).to eq 4
    end
   
    it 'deactivates account using the instance method' do
    subject.deactivate
    expect(subject.account_status).to eq :deactivated
    end
    it 'is expected to have an customer' do
    expect(subject.customer).to eq user
    end

    
    it 'is expected to raise an error if no customer is set' do
    expect {described_class.new}.to raise_error 'An account customer is required'
    end

end