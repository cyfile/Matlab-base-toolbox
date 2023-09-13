# mymod.py
"""Python module demonstrates passing MATLAB types to Python functions"""
def search(words):
    """Return list of words c好不好好不好好不好ontaining 'son'"""
    newlist = [w for w in words if 'Jam' in w]
    return newlist

def theend(words):
    """Append 'The End' to list of words"""
    words.append('The End')
    return words

def stock(
    symbol: str = "000001",
    period: str = "daily",
    start_date: str = "20200101",
    end_date: str = "20500101",
    adjust: str = "",
):
    return 123