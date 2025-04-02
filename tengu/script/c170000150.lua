--デス・ウイルス・ドラゴン (Anime)
--Doom Virus Dragon (Anime)
function c170000150.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,true,true,57728570,11082056)
	--Destroy all monsters your opponent controls with 1500 or more ATK
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c170000150.desop)
	c:RegisterEffect(e1)
	--Check face-down monsters to confirm stats
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_MSET)
	e2:SetOperation(c170000150.fdchkop)
	c:RegisterEffect(e2)
end
c170000150.material_trap=57728570 --Crush Card Virus
function c170000150.desfilter(c)
	return c:IsFaceup() and c:GetAttack()>=1500 and c:IsDestructable() and not c:IsCode(c170000150)
end
function c170000150.fdchkfilter(c)
	return c:IsFacedown() and c:IsAttackAbove(1500) and c:IsDestructable()
end
function c170000150.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c170000150.desfilter,tp,0,LOCATION_MZONE,nil)
	local conf=Duel.GetMatchingGroup(c170000150.fdchkfilter,tp,0,LOCATION_MZONE,nil)
	if #conf>0 then
		Duel.ConfirmCards(tp,conf)
		g:Merge(conf)
	end
	Duel.Destroy(g,REASON_EFFECT)
end
function c170000150.fdchkop(e,tp,eg,ep,ev,re,r,rp)
	local conf=Duel.GetFieldGroup(tp,0,LOCATION_MZONE,POS_FACEDOWN)
	if #conf>0 then
		Duel.ConfirmCards(tp,conf)
	end
end