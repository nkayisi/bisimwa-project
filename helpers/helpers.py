import random


def matriculeGenerator():

    leters = "abcdefghijklmnopkrstuvwxyz"
    numbers = "0123456789"


    use_for = leters.upper() + numbers
    length_for_matricule = 8

    matricule = "".join(random.sample(use_for, length_for_matricule))

    return matricule


