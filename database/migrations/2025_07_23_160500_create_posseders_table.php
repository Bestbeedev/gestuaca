<?php

use App\Models\Etudiant;
use App\Models\Niveau;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use App\Models\Filiere;
use App\Models\Matiere;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('posseders', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(Niveau::class)->constrained()->onDelete('cascade');
            $table->foreignIdFor(Filiere::class)->constrained()->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('posseders');
    }
};
