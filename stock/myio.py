
def myfun(s):
    assert 1==1
    for k in s:
        print(k['code'])
        print(k['price'])
        print(type(k['price']))
    return [None, 9.92, None]

if 'action' in dir():
    if action == 'b' :
        z = myfun(data)
    elif action == 's' :
        z = myfun(data)
    else :
        print('error')
else :
    data = [{'code':'123456','price':11},{'code':'222222','price':22}]
    z = myfun(data)


#raise SystemExit



'''HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH'''


'''HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH'''
