<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Annee extends Model
{
    protected $fillable = ['date_debut', 'date_fin', 'active'];

    public function inscriptions()
    {
        return $this->hasMany(Inscription::class);
    }
}
