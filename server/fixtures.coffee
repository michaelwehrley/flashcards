if Questions.find().count() == 0
  a = 0
  while a < 26
    b = 0
    while b < 26
      level = "1" if (0 <= a and a < 5) and (0 <= b and b < 5)
      level = "2" if (5 <= a and a < 10) and (5 <= b and b < 10)
      level = "3" if (10 <= a and a < 15) and (10 <= b and b < 15)
      level = "4" if (15 <= a and a < 20) and (15 <= b and b < 20)
      level = "5" if (20 <= a and a <= 25) and (20 <= b and b <= 25)
      unless Questions.findOne({factorA: a, factorB: b})
        Questions.insert({
          factorA: a,
          factorB: b,
          level: level
          product: a * b,
          questionResponders: [],
          responseCount: 0
        })
      b++
    a++