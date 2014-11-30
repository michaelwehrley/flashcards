if Questions.find().count() == 0
  a = 0
  while a < 21
    console.log('a', a)
    b = 0
    while b < 21
      console.log('b', b)
      Questions.insert({
        factorA: a,
        factorB: b,
        product: a * b
      })
      b++
    a++