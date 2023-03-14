import matplotlib.pyplot as plt
import numpy as np
import random as r
import time



def main():
    moneyline = input("Enter moneyline:")
    moneyline = int(moneyline)

    show_p_vs_kelly_fraction_graph(moneyline)

    time.sleep(3)

    p = input("odds of winning:")
    p = float(p)
    bankroll = input("bankroll:")
    bankroll = float(bankroll)

    fraction = get_kelly_fraction(moneyline, p)

    if fraction <= 0:
        print("Negative Kelly fraction, no bet")
    else:
        for i in range(0,1000):
            bankroll = gamble(bankroll,fraction,p,moneyline)
            print(str(bankroll))
    

    # print("You should bet " + str(fraction*100) + "% of your money.")
    # print("-----------------------------------------")
    # print("b = " + str(b))
    # print("p = " + str(p))
    # p_list = []
    # kelly_list = []
    # p = 0
    # while p <= 1:
    #     p_list.append(p)
    #     kelly_list.append(get_kelly_fraction(moneyline,p))
    #     p += 0.05

    # xpoints = np.array(p_list)
    # ypoints = np.array(kelly_list)
    # plt.plot(xpoints, ypoints)
    # plt.show()



#------------------------------------------------------

def get_kelly_fraction(moneyline: int, p: float) -> float:
    q = 1 - p
    if moneyline < 0:
        b = 100 / abs(moneyline)
    else:
        b = moneyline / 100
    fraction = p - q / b
    fraction = round(fraction,4)
    return fraction



def gamble(bankroll: float, kelly_fraction: float, p: float, moneyline: int) -> float:
    bet = kelly_fraction*bankroll
    bankroll -= bet
    roll = r.random()
    if roll <= p:
        if moneyline > 0:
            bankroll += bet
            bankroll += bet * moneyline / 100
        else:
            bankroll += bet * ((abs(moneyline) + 100)/abs(moneyline))
    return bankroll


def show_p_vs_kelly_fraction_graph(moneyline: int):
    p_list = []
    kelly_list = []
    p = 0
    while p <= 1:
        p_list.append(p)
        kelly_list.append(get_kelly_fraction(moneyline,p))
        p += 0.05

    xpoints = np.array(p_list)
    ypoints = np.array(kelly_list)
    plt.plot(xpoints, ypoints)
    plt.xlabel("winning odds (p)")
    plt.ylabel("Kelly fraction (f*)")
    xpoints = np.array([0,1])
    ypoints = np.array([0,0])
    plt.plot(xpoints, ypoints)
    plt.show()

#-----MAIN------#
main()