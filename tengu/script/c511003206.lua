--マガジンドラムゴン (Anime)
--Vorticular Drumgon (Anime)
--Scripted by the Razgriz
function c511003206.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	Link.AddProcedure(c,c511003206.matfilter,3,3)
	--Draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511003206(c511003206,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,c511003206)
	e1:SetTarget(c511003206.drtg)
	e1:SetOperation(c511003206.drop)
	c:RegisterEffect(e1)
	--Cannot Summon to Monster Zones
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_FORCE_MZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(1,1)
	e2:SetValue(function(e)return ~e:GetHandler():GetLinkedZone() end)
	e2:SetCondition(c511003206.nscon)
	c:RegisterEffect(e2)
end
function c511003206.matfilter(c,scard,sumtype,tp)
	return c:IsRace(RACE_DRAGON,scard,sumtype,tp) and c:IsAttribute(ATTRIBUTE_DARK,scard,sumtype,tp)
end
function c511003206.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511003206.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	e:GetHandler():RegisterFlagEffect(c511003206,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,0)
end
function c511003206.nscon(e)
	return e:GetHandler():GetFlagEffect(c511003206)~=0
end