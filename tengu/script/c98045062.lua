--エネミーコントローラー
--Enemy Controller
function c98045062.initial_effect(c)
	--Activate 1 of these effects
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc98045062(c98045062,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_BATTLE_PHASE|TIMING_STANDBY_PHASE,TIMING_BATTLE_PHASE)
	e1:SetCost(c98045062.cost)
	e1:SetTarget(c98045062.target)
	e1:SetOperation(c98045062.activate)
	c:RegisterEffect(e1)
end
function c98045062.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(9)
	return true
end
function c98045062.cfilter(c,tp)
	return Duel.GetMZoneCount(tp,c,tp,LOCATION_REASON_CONTROL)>0 and Duel.IsExistingTarget(aux.FaceupFilter(Card.IsControlerCanBeChanged,true),tp,0,LOCATION_MZONE,1,c)
end
function c98045062.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then
		if not (chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() and chkc:IsControler(1-tp)) then return false end
		if e:GetLabel()==1 then
			return chkc:IsCanChangePosition()
		else
			return chkc:IsControlerCanBeChanged()
		end
	end
	local b1=Duel.IsExistingTarget(aux.FaceupFilter(Card.IsCanChangePosition),tp,0,LOCATION_MZONE,1,nil)
	local b2=nil
	if e:GetLabel()==9 then
		b2=Duel.CheckReleaseGroupCost(tp,c98045062.cfilter,1,false,nil,nil,tp)
	else
		b2=Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_CONTROL)>0
			and Duel.IsExistingTarget(aux.FaceupFilter(Card.IsControlerCanBeChanged),tp,0,LOCATION_MZONE,1,nil)
	end
	if chk==0 then
		e:SetLabel(0)
		return b1 or b2
	end
	local op=Duel.SelectEffect(tp,
		{b1,aux.Stringc98045062(c98045062,1)},
		{b2,aux.Stringc98045062(c98045062,2)})
	if op==1 then
		e:SetCategory(CATEGORY_POSITION)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
		local g=Duel.SelectTarget(tp,aux.FaceupFilter(Card.IsCanChangePosition),tp,0,LOCATION_MZONE,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
	else
		e:SetCategory(CATEGORY_CONTROL)
		if e:GetLabel()==9 then
			local rg=Duel.SelectReleaseGroupCost(tp,c98045062.cfilter,1,1,false,nil,nil,tp)
			Duel.Release(rg,REASON_COST)
		end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
		local g=Duel.SelectTarget(tp,aux.FaceupFilter(Card.IsControlerCanBeChanged),tp,0,LOCATION_MZONE,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
	end
	e:SetLabel(op)
end
function c98045062.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not (tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsControler(1-tp)) then return end
	if e:GetLabel()==1 then
		--Change that target's battle position
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
	else
		--Take control of that target until the End Phase
		Duel.GetControl(tc,tp,PHASE_END,1)
	end
end