--カース・オブ・ヴァンパイア (Manga)
--Vampire's Curse (Manga)
function c511008509.initial_effect(c)
	--Special Summon this card if destroyed and sent to GY
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511008509(c511008509,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c511008509.spcon)
	e1:SetCost(c511008509.spcost)
	e1:SetOperation(c511008509.spop)
	e1:SetLabel(0)
	c:RegisterEffect(e1)
	--Increase ATK if Special Summoned by above effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511008509(c511008509,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511008509.atkcon)
	e2:SetOperation(c511008509.atkop)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
function c511008509.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_DESTROY)
end
function c511008509.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c511008509.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	e:SetLabel(e:GetLabel()+1)
	Duel.SpecialSummon(c,1,tp,tp,false,false,POS_FACEUP)
end
function c511008509.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+1
end
function c511008509.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(500*e:GetLabelObject():GetLabel())
		e1:SetReset(RESET_EVENT|RESETS_STANDARD_DISABLE)
		c:RegisterEffect(e1)
	end
end