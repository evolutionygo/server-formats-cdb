--体力増強剤スーパーZ
--Nutrient Z (GOAT)
--Very weird activation window
function c504700051.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c504700051.condition)
	e1:SetTarget(c504700051.target)
	e1:SetOperation(c504700051.activate)
	c:RegisterEffect(e1)
	local ge=Effect.CreateEffect(c)
	ge:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	ge:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	ge:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	ge:SetCondition(c504700051.condition2)
	ge:SetOperation(c504700051.activate2)
	Duel.RegisterEffect(ge,0)
end
function c504700051.activate2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local eff=c:GetActivateEffect()
	eff:SetLabel(1)
	local act=eff:IsActivatable(tp,false,false)
	eff:SetLabel(0)
	if act and Duel.SelectEffectYesNo(tp,c,95) then
		Duel.RegisterFlagEffect(tp,c504700051,RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
		Duel.Activate(c:GetActivateEffect())
	end
end
function c504700051.condition2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if not c:IsLocation(LOCATION_HAND+LOCATION_SZONE) then return end
	return Duel.GetBattleDamage(tp)>=2000
end
function c504700051.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabel()==1 or Duel.GetFlagEffect(tp,c504700051)>0
end
function c504700051.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,4000)
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		Duel.SetChainLimitTillChainEnd(c504700051.chlimit)
	end
end
function c504700051.chlimit(re,rp,tp)
	return (re:GetHandler():IsType(TYPE_COUNTER) and re:IsHasType(EFFECT_TYPE_ACTIVATE)) or re:GetHandler():IsCode(c504700051)
end
function c504700051.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Recover(tp,4000,REASON_EFFECT)
end