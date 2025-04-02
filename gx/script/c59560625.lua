--シフトチェンジ
--Shift
function c59560625.initial_effect(c)
	--Change battle target
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc59560625(c59560625,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c59560625.condition1)
	e1:SetTarget(c59560625.target1)
	e1:SetOperation(c59560625.activate1)
	c:RegisterEffect(e1)
	--Change effect target
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc59560625(c59560625,1))
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(c59560625.condition2)
	e2:SetTarget(c59560625.target2)
	e2:SetOperation(c59560625.activate2)
	c:RegisterEffect(e2)
end
function c59560625.condition1(e,tp,eg,ep,ev,re,r,rp)
	local a,d=Duel.GetAttacker(),Duel.GetAttackTarget()
	return a and d and a:IsControler(1-tp) and d:IsControler(tp)
end
function c59560625.target1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local ag=Duel.GetAttacker():GetAttackableTarget()
	local at=Duel.GetAttackTarget()
	if chk==0 then return ag:IsExists(Card.IsCanBeEffectTarget,1,at,e) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local tg=ag:FilterSelect(tp,Card.IsCanBeEffectTarget,1,1,at,e)
	Duel.SetTargetCard(tg)
end
function c59560625.activate1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and not Duel.GetAttacker():IsImmuneToEffect(e) then
		Duel.ChangeAttackTarget(tc)
	end
end
function c59560625.condition2(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or not re:IsHasType(EFFECT_TYPE_ACTIVATE) or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or #g~=1 then return false end
	local tc=g:GetFirst()
	e:SetLabelObject(tc)
	return tc:IsControler(tp) and tc:IsLocation(LOCATION_MZONE)
end
function c59560625.filter(c,ct)
	return Duel.CheckChainTarget(ct,c)
end
function c59560625.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=e:GetLabelObject()
	if chkc then return chkc~=tc and chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c59560625.filter(chkc,ev) end
	if chk==0 then return Duel.IsExistingTarget(c59560625.filter,tp,LOCATION_MZONE,0,1,tc,ev) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c59560625.filter,tp,LOCATION_MZONE,0,1,1,tc,ev)
end
function c59560625.activate2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.ChangeTargetCard(ev,Group.FromCards(tc))
	end
end