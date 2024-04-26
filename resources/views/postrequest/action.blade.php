 
<?php
    $auth_user= authSession();
?>
{{ Form::open(['route' => ['post-job-request.destroy', $post_job->id], 'method' => 'delete','data--submit'=>'post_job'.$post_job->id]) }}
@if(auth()->user()->hasAnyRole(['admin']))
<div class="d-flex justify-content-end align-items-center">
        <a class="" href="{{ route('post-job-request.show', $post_job->id) }}" title="{{ __('messages.view_form_title',['form'=>  __('messages.postjob') ]) }}"><i class="far fa-eye text-secondary mr-2"></i></a>
    </div>
@endif
{{ Form::close() }}