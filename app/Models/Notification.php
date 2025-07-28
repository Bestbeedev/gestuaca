<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Notification extends Model
{
    protected $fillable = ['date_envoi', 'message', 'id_user'];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
