<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Niveau extends Model
{
    protected $fillable = ['nom'];

    public function posseder()
    {
        return $this->hasMany(Posseder::class);
    }
}
