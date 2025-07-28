<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Matiere extends Model
{
    protected $fillable = ['nom', 'code', 'id_enseignant'];

    public function enseignant()
    {
        return $this->belongsTo(Enseignant::class);
    }
}
