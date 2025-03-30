const stripe = require('stripe')('sk_test_51R8A2RGaKispscj83xabQLzKvsYrZ8OGRsd8TgBieuYdu3KWsdSiCKjLvj2mSRd9g6lKZxb9z6eCpl5NscTt0Czs00IYGDn5i6');

exports.createPaymentIntent = async (req, res) => {
    const { totalAmount } = req.body 
    // ensure totalAmount is a valid number 
    if(typeof totalAmount !== "number" || isNaN(totalAmount)) {
        return res.status(400).json({ error: "Invalid totalAmount" });
    }

    // Convert dollars to cents
    let totalAmountInCents = Math.round(totalAmount * 100);
    
    // Enforce Stripe's minimum charge amount (50 cents for USD)
    const MINIMUM_CHARGE_AMOUNT = 50; // 50 cents in USD
    if (totalAmountInCents < MINIMUM_CHARGE_AMOUNT) {
        totalAmountInCents = MINIMUM_CHARGE_AMOUNT;
        console.log(`Adjusted charge amount to minimum ${MINIMUM_CHARGE_AMOUNT} cents`);
    }
    
    try {
        // use an existing customer ID if this is a returning customer 
        const customer = await stripe.customers.create();
        const ephemeralKey = await stripe.ephemeralKeys.create(
            { customer: customer.id }, 
            { apiVersion: '2017-06-05' }
        );
        
        // create payment intent 
        const paymentIntent = await stripe.paymentIntents.create({
            amount: totalAmountInCents, 
            currency: 'usd', 
            customer: customer.id,
            automatic_payment_methods: {
                enabled: true
            } 
        });
        
        res.json({
            paymentIntent: paymentIntent.client_secret, 
            ephemeralKey: ephemeralKey.secret, 
            customer: customer.id, 
            publishableKey: 'pk_test_51R8A2RGaKispscj8yVe8jK8FuEKqEHYryRdtIcg7we53nWK5c3MVlSGZOi2KhtjTswq5SkL83PxyYXngkOALyN6500vz9131Xg'
        });
    } catch (error) {
        console.error('Stripe error:', error);
        res.status(500).json({ 
            error: error.message,
            success: false
        });
    }
}




