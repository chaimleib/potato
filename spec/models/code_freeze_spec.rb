require 'rails_helper'
require 'ap'

RSpec.describe CodeFreeze, type: :model do
  before do
    @cf = FactoryGirl.build :code_freeze
  end
  
  it 'is valid from the factory' do
    expect(@cf).to be_valid
  end
  
  describe 'version' do
    it 'is not empty' do
      @cf.version = ''
      expect(@cf).to_not be_valid
    end
    
    it 'is not nil' do
      @cf.version = nil
      expect(@cf).to_not be_valid
    end
    
    it 'is unique' do
      
      cf2 = @cf.dup
      
      cf3 = @cf.dup
      cf3.version = 'v2'
      expect(@cf.version).to_not eq(cf3.version)
      
      @cf.save
      
      expect(cf2).to_not be_valid
      expect(cf3).to be_valid
    end
      
  end
  
  describe 'date' do
    it 'can be blank' do
      @cf.date = ''
      expect(@cf).to be_valid
    end
    
    it 'can be nil' do
      @cf.date = nil
      expect(@cf).to be_valid
    end
    
    it 'does not accept an invalid ISO8601 date' do
      @cf.date = 'invalid ISO8601'
      expect(@cf).to_not be_valid
    end
    
    it 'can\'t be too long (> 26 char)' do
      @cf.date = '2012-10-06T04:13:00.123456789+00:00'
      expect(@cf).to_not be_valid
    end
  end
end
