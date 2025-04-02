--暴君の自暴自棄
--Tyrant's Throes
function c55271628.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c55271628.cost)
	c:RegisterEffect(e1)
	--Cannot Normal or Special Summon Effect Monsters
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_SUMMON)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(1,1)
	e2:SetTarget(c55271628.sumlimit)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	c:RegisterEffect(e3)
end
function c55271628.cfilter(c)
	return c:IsType(TYPE_NORMAL) and not c:IsType(TYPE_TOKEN)
end
function c55271628.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c55271628.cfilter,2,nil) end
	local rg=Duel.SelectReleaseGroup(tp,c55271628.cfilter,2,2,nil)
	Duel.Release(rg,REASON_COST)
end
function c55271628.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	if c:IsMonster() then
		return c:IsType(TYPE_EFFECT)
	else
		return c:IsOriginalType(TYPE_EFFECT)
	end
end