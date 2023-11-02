import random
def test():
     ranlist=[random.randint(1,4) for i in range(random.randint(2,4))]
     total=0
     for i in ranlist:
         total+=i
     
   
    grid_sort(random.randint(4,8),random.randint(4,8),)

def grid_sort(grid_width,grid_length,boat_list):
    grid=[['_' for i in range( grid_width)] for i in range(grid_length)]
    for i in grid:
        print(i)

    boat_list.sort(reverse=True)
    for i in boat_list:
        print(i)
    boat_count=1
    for i in boat_list:
         for row in grid:
             space_map=[]
             count=0
             for space in row:
                if space=='_':
                    count+=1
                elif count!=0:
                    space_map.append(count)
                    count=0
            print(space_map)
    for i in grid:
        print(i)
    
                
    
test()
