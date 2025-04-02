--ダーク・ヴァルキリア
--Dark Valkyria
function c83269557.initial_effect(c)
	Gemini.AddProcedure(c)
	c:EnableCounterPermit(COUNTER_SPELL,LOCATION_MZONE,Gemini.EffectStatusCondition)
	--Gain 300 ATK for each Spell Counter
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(Gemini.EffectStatusCondition)
	e1:SetValue(function(_,c) return c:GetCounter(COUNTER_SPELL)*300 end)
	c:RegisterEffect(e1)
	--Place 1 Spell Counter
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc83269557(c83269557,0))
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(Gemini.EffectStatusCondition)
	e2:SetTarget(c83269557.target1)
	e2:SetOperation(c83269557.operation1)
	c:RegisterEffect(e2)
	--Destroy 1 monster
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc83269557(c83269557,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(Gemini.EffectStatusCondition)
	e3:SetCost(c83269557.cost2)
	e3:SetTarget(c83269557.target2)
	e3:SetOperation(c83269557.operation2)
	c:RegisterEffect(e3)
end
c83269557.counter_place_list={COUNTER_SPELL}
function c83269557.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanAddCounter(COUNTER_SPELL,1) end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0)
end
function c83269557.operation1(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(COUNTER_SPELL,1)
end
function c83269557.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanRemoveCounter(tp,COUNTER_SPELL,1,REASON_COST) end
	c:RemoveCounter(tp,COUNTER_SPELL,1,REASON_COST)
end
function c83269557.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c83269557.operation2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end