--異次元の精霊
--D.D. Sprite
function c16638212.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c16638212.spcon)
	e1:SetTarget(c16638212.sptg)
	e1:SetOperation(c16638212.spop)
	c:RegisterEffect(e1)
end
function c16638212.spcon(e,c)
	if c==nil then return true end
	return Duel.IsExistingMatchingCard(aux.AND(Card.IsAbleToRemoveAsCost,Card.IsFaceup),e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c16638212.sptg(e,tp,eg,ep,ev,re,r,rp,c)
	local rg=Duel.GetMatchingGroup(Card.IsAbleToRemoveAsCost,tp,LOCATION_MZONE,0,nil):Filter(Card.IsFaceup,nil)
	local g=aux.SelectUnselectGroup(rg,e,tp,1,1,aux.ChkfMMZ(1),1,tp,HINTMSG_REMOVE,nil,nil,true)
	if #g>0 then
		g:KeepAlive()
		e:SetLabelObject(g)
		return true
	end
	return false
end
function c16638212.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	if not g then return end
	Duel.Remove(g,POS_FACEUP,REASON_COST+REASON_TEMPORARY)
	g:GetFirst():RegisterFlagEffect(c16638212,RESET_EVENT+RESETS_STANDARD,0,0)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc16638212(c16638212,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetCountLimit(1)
	e1:SetReset((RESET_EVENT|RESETS_STANDARD_DISABLE)&~RESET_TOFIELD|RESET_PHASE|PHASE_STANDBY)
	e1:SetOperation(c16638212.retop)
	e1:SetLabelObject(g:GetFirst())
	c:RegisterEffect(e1)
	g:DeleteGroup()
end
function c16638212.retop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject():GetFlagEffect(c16638212)~=0 then
		Duel.ReturnToField(e:GetLabelObject())
	end
end