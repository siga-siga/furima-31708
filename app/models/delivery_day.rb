class DeliveryDay < ActiveHash::Base
  self.data = [
    { id: 1, date: '---' },
    { id: 2, date: '1~2日で発送' },
    { id: 3, date: '2~3日で発送' },
    { id: 4, date: '4~7日で発送' }
  ]
end
