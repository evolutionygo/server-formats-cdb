--光のピラミッド (Anime)
--Pyramc511001887 of Light (Anime)
function c511001887.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Banish all Monster Cards on the field whose original Type is Divine-Beast
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c511001887.banop)
	c:RegisterEffect(e2)
end
function c511001887.filter(c)
	return c:IsFaceup() and c:IsOriginalRace(RACE_DIVINE) and c:IsAbleToRemove()
end
function c511001887.banop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511001887.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end