<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\DataTables\BookingRatingDataTable;
use App\Models\BookingRating;

class BookingRatingController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(BookingRatingDataTable $dataTable)
    {
        $pageTitle = __('messages.user_ratings');
        $auth_user = authSession();
        $assets = ['datatable'];
        return $dataTable->render('bookingrating.index', compact('pageTitle','auth_user','assets'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        if(demoUserPermission()){
            return redirect()->back()->withErrors(trans('messages.demo.permission.denied'));
        }
        $bookingrating = BookingRating::find($id);
        $msg= __('messages.msg_fail_to_delete',['name' => __('messages.user_ratings')] );

        if($bookingrating != ''){
            $bookingrating->delete();
            $msg= __('messages.msg_deleted',['name' => __('messages.user_ratings')] );
        }
        return comman_custom_response(['message'=> $msg, 'status' => true]);
    }
}
