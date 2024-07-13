const origins = []

for (let i = 0; i < 20; i++) { 
    origins.push('http://localhost:' + (3000 + i)); 
}
for (let i = 0; i <= 40; i+= 10) { 
    origins.push('http://localhost:' + (3100 + i));  
}
origins.push('https://egotton-admin-acc291dfe8c9.herokuapp.com')
origins.push('https://egotton-shop-5714cbc4e279.herokuapp.com')
origins.push('https://egotton.com')
origins.push('https://www.egotton.com')
origins.push('https://admin.egotton.com')
origins.push('https://www.admin.egotton.com')
origins.push('https://www.shop.egotton.com')

export const corsOrigins = origins 