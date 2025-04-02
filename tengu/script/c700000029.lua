--幻奏の華歌聖ブルーム・プリマ (Anime)
--Bloom Prima the Melodious Choir (Anime)
--Scripted by Eerie Code. fixed by MLD
Duel.LoadScript("c420.lua")
function c700000029.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2Rep(c,true,true,aux.FilterBoolFunctionEx(Card.IsSetCard,0x9b),1,99,aux.FilterBoolFunctionEx2(Card.IsMelodiousSongtress))
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MATERIAL_CHECK)
	e1:SetValue(c700000029.matcheck)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
c700000029.listed_series={0x9b}
c700000029.material_setcode={0x9b,0x209b}
function c700000029.matcheck(e,c)
	local ct=c:GetMaterialCount()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(ct*300)
	e1:SetReset(RESET_EVENT|RESETS_STANDARD_DISABLE&~RESET_TOFIELD)
	c:RegisterEffect(e1)
end