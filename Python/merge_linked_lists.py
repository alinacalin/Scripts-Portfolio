#
# Given two sprted lists as SingleLinkedListNode, merge them keeping the double values.
#
#
def mergeLists(head1, head2):
    if head1 == None :
        return head2
    if head2 == None:
        return head1
    h1n=head1 
    h2n=head2
    if h1n.data>h2n.data:
            startm=SinglyLinkedListNode(h2n.data)
            h2n=h2n.next 
            
    else:
            startm=SinglyLinkedListNode(h1n.data)
            h1n=h1n.next 
   
    endm=startm
    while h1n !=None and h2n!= None:
        if h1n.data > h2n.data :
            e1=SinglyLinkedListNode(h2n.data)
            endm.next=e1
            endm=e1 
            h2n=h2n.next
        elif h1n.data == h2n.data :
            e2=SinglyLinkedListNode(h2n.data)
            e1=SinglyLinkedListNode(h1n.data)
            e1.next=e2
            endm.next=e1
            endm=e2 
            h1n=h1n.next
            h2n=h2n.next
        else:
            e1=SinglyLinkedListNode(h1n.data)
            endm.next=e1
            endm=e1 
            h1n=h1n.next
    
    while h1n !=None :
        e1=SinglyLinkedListNode(h1n.data)
        endm.next=e1
        endm=e1 
        h1n=h1n.next
        
    while h2n !=None :
        e1=SinglyLinkedListNode(h2n.data)
        endm.next=e1
        endm=e1 
        h2n=h2n.next
          
            
    return startm
