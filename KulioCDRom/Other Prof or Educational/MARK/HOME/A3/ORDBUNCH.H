// ordbunch.h  M.H.Atkinson
// 11/17/92

#ifndef ORDBUNCH_H
#define ORDBUNCH_H

#include "bunch.h"

#include "mytypes.h"

#include <iostream.h>

class ordbunch: public bunch
{

protected:

 
public:
	
//	no constructor is required.
//	It uses the bunch constructor.

//	no destructor is required.
//	It uses the bunch destructor.


//	no copy constructor is required
//	it used the one in bunch.

//******************************************************************
//
//
	ordbunch& operator=( const ordbunch& ob);
		// so that we can invoke copies at declaration
	

// function insert is the only function that is different
// in this class ordbunch from the parrent class bunch
	
	void insert( char c );

	
// function make_room
	void make_room( long worker, long insrt_pt);


};
#endif

//**************************************************************
//
// this is the end of file order_bunch.h
//
//*************************************************************
