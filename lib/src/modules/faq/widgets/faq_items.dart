class FaqItem {
  final String title;
  final String content;

  FaqItem(this.title, this.content);
}

final List<FaqItem> faqItems = [
  FaqItem(
    'About StoxHero',
    '''What is StoxHero?
StoxHero is India's fastest growing options trading learning platform aimed at helping genZ master the art of 'Trading'. On StoxHero, Traders learn how to pick the right contracts using virtual money by participating in experiential learning programs.
Do I Trade Contracts With Real Money?
No, you trade with virtual money. This money can be used to build a portfolio consisting of virtual contracts.
''',
  ),
  FaqItem(
    'Login & Registration',
    '''How Do I Register On StoxHero?
• Enter your First Name
• Enter your Last Name
• Enter your Email ID
• Enter your Mobile Number
• Hit on SignUp and confirm your OTP
• Check your email for account details

Where Can I Find an Invitation Code?
You don't need an invitation code to sign up on the website. This is an optional feature applicable when a user is being invited by another registered user or StoxHero Ambassador. So if you don't have an invitation code, you can proceed without entering it.
''',
  ),
  FaqItem(
    'Portfolios',
    '''
What Is A Portfolio?
• A portfolio is a collection of stocks. On StoxHero, one Trading portfolio and two empty battle portfolios (Mania and Fever) are provided at the time of registration.
• You can buy or sell contracts to add new positions to the portfolios.
• Once added, every position will either be in a state of profit or loss.
• To check this, you can open the relevant portfolio.
• To remove a position from the portfolio, you must execute a transaction in the opposite direction i.e. to close a buy trade, you must sell the stock and vice versa.

What Are Mania And Fever Portfolios?
Mania and Fever Portfolios are Lifetime Free Battle Portfolios. This means that these portfolios can be used to participate in the daily, weekly, and special battles that run on the app.

Every time you register in a battle, you are required to link one of the two portfolios. Each of them contains INR 10,00,000 virtual currency which can be used to buy or sell contracts.

Do note, Mania and Fever Portfolios get exhausted with the losses you make in the contest.

What Is A Trading Portfolio?
Trading portfolio is similar to the Mania and Fever Portfolios but it cannot be linked to any battle.
The purpose of this portfolio is to help users learn options trading by participating in virtual trading that do not reset every time a battle ends. Buy and Sell trades can be executed using the Trading Portfolio but they remain open until you square off i.e. sell the stocks/contract you bought and vice versa.
This can be used to test different options trading Strategies.

What Is The Difference Between Mania And Fever Portfolios?
There is no difference between Mania and Fever Portfolios. They exist only to help you participate in two different battles at the same time. You can only link one portfolio to one battle at any given time. So, with these two portfolios, you can only participate in two different battles simultaneously.

Can I Join Multiple Leagues With The Same Portfolio?
No, you can only join 1 league with 1 portfolio.

Can I Join A League With Multiple Portfolios?
No, you can only join a league with a single portfolio.

Is There A Limit On The Number Of Portfolios I Can Use?
Yes, as of now, StoxHero provides 1 Trading Portfolio and 2 battle portfolios at the time of registration, you can buy an additional portfolio by taking the subscription.

What Is Virtual Margin Money? How Is It Different From Opening Balance?
• Virtual Margin Money reflects the value of your portfolio after accounting for realized & unrealized profit or loss, transaction charges, and cash balance.
• Opening balance reflects cash available before taking any trade for that day.
''',
  ),
//   FaqItem(
//     'StoxHero Battles',
//     '''
// What Is A Battle?
// A battle is where different StoxHero users compete against each other using their portfolios to win rewards. After joining the battle and adding stocks/contract to the linked portfolio, users are assigned ranks based on the portfolio's performance. Depending on your rank category, you may or may not win a reward. Such battles run on all business days for varying time periods (daily, weekly, monthly, etc.)

// Can I Create My Own League?
// Currently, only StoxHero can create battles. Please contact us if you are interested in creating custom Battles @ team@stoxhero.com.

// What is 'Upcoming Battles' tab?
// Upcoming Battles tab has all those battles which are yet to start. You can register for these battles subject to availability of seats.

// What is 'My Battle' tab?
// My Battles tab has all those battles which you've enrolled in and are yet to end.

// What is 'History' tab?
// History tab has all those battles in which you've participated.

// Can I Join Battle Every Day And At Any Time?
// Battles run during regular market hours. Each Battle has specific timings associated with it, which can be viewed by clicking on the Battle in the 'Upcoming Battle' section under 'Battle Ground' tab.

// How Can I Join Leagues?
// • To join Battle, tap on 'Battle Ground'
// • All upcoming battles will be listed here
// • Find a Battle of your choice which has seats 'Left'
// • On the next screen, battle rules and rewards table are displayed.
// • Accept the League 'Terms & Conditions' and click 'Register'
// • Accept the League 'Terms & Conditions' and click 'Register'
// • Next, Link one of the available battle Portfolios and click on 'Join'
// • Now you can go to 'My Battles' tab to see the battle in which you have registered

// What Are The Rules Of A Battle?
// • Every user who joins a Battle needs to link an unlinked league portfolio to it
// • Note that a portfolio can be linked to one Battle only and one Battle will only support one portfolio
// • Once the portfolio is linked, the user can come to the battle and after the battle starts can buy and sell contracts
// • To find more rules specific to the Battle, check out the battle rules inside Battle Info section

// Can I Exit The Battle Before It Starts?
// Yes, a battle can be exited before it starts.

// Where Can I See The Battle I Joined In The Past?
// You can visit 'History' tab under Battle Ground tab to see the battles which you joined in the past.

// What Is 'Transaction Fee'?
// Each time a trade is executed on the StoxHero App, a transaction fee of 20 Rupees/Order + standard NSE/BSE, STT/CTT, STAMP Duty, GST charges on the total traded value is charged on the buy as well as sell side side. This is deducted from INR 10,00,000 virtual cash in your portfolio.

// When Does Trading Start On The StoxHero App?
// In the Trading Portfolio, you can start trading at 9:15 AM when the market opens. However, in the case of battles, please check the Battle Ground section as each battle has a different starting time. Do note - all battles start after 9:30 AM and end before 3:25 PM.
// ''',
//   ),
  FaqItem(
    'Points & Ranking System',
    '''
When Are The Winners Announced?
Winners are announced at the end of the Battle. Participants must visit the 'Ranks' section inside a Battle under 'History' tab to know their position.

How Are The Winners Decided?
Participants are ranked on the basis of the profit made in that contest.

How Are Rewards Distributed To The Players?
All the Battles participants are continuously ranked in the order of their return. At the end of the Battle, the rewards are distributed among the top rankers in the predetermined ratio. This ratio is published in advance on the Battle Rules page that appears at the time of joining the league.

What Is The Hero's Chart?
All StoxHero users are ranked continuously based on the total amount of rewards across battles. The top users are recognized in the Hero's Chart that can be accessed from the side menu.
''',
  ),
  FaqItem(
    'StoxHero Account',
    '''What Is A StoxHero Account?
StoxHero Account reflects all your rewards. It shows your StoxHero cash and Bonus cash balance.

How Can I Withdraw Money From My StoxHero Account?
Currently you will get the withdrawal amount through UPI from StoxHero, for that you need to raise a request through email.

What Are The Limits For Withdrawing Money?
For all listed Payment Methods (PayTm, Bank and UPI transfer), the following withdrawal limits apply :
• Minimum Withdrawal Amount Per Transaction: Rs. 500/-
• Maximum Withdrawal Amount Per Transaction: Rs. 1000/-
• Maximum Daily Withdrawal Amount: Rs. 1000/-

What Is Hero Cash? Can I Withdraw It?
In StoxHero Account, Hero cash is the in-app currency that's awarded on various activities like when you invite friends through a referral program which giving Hero Cash onto the platform. The amount is not withdrawable but it can be used to redeem exciting coupons.
''',
  ),
];
