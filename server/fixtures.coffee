if Questions.find().count() == 0
  a = 0
  while a < 26
    b = 0
    while b < 26
      unless Questions.findOne({factorA: a, factorB: b})
        Questions.insert({
          factorA: a,
          factorB: b,
          product: a * b
        })
      b++
    a++