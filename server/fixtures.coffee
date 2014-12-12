if Questions.find().count() == 0
  a = 0
  while a < 26
    b = a
    while b < 26
      product = a * b
      if product >= 600
        level = "17"
      if product >= 550
        level = "16"
      else if product >= 500
        level = "15"
      else if product >= 450
        level = "14"
      else if product >= 400
        level = "13"
      else if product >= 350
        level = "12"
      else if product >= 300
        level = "11"
      else if product >= 250
        level = "10"
      else if product >= 200
        level = "9"
      else if product >= 150
        level = "8"
      else if product >= 100
        level = "7"
      else if product >= 75
        level = "6"
      else if product >= 50
        level = "5"
      else if product >= 40
        level = "4"
      else if product >= 30
        level = "3"
      else if product >= 20
        level = "2"
      else
        level = "1"
      unless Questions.findOne({factorA: a, factorB: b})
        console.log("a", a)
        console.log("b", b)
        console.log("level", level)
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