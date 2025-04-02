--機甲忍法ラスト・ミスト
--Armor Ninjitsu Art of Rust Mist
function c2148918.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c2148918.target)
	e1:SetHintTiming(TIMING_SPSUMMON)
	c:RegisterEffect(e1)
	--atk change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc2148918(c2148918,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c2148918.spcon)
	e2:SetTarget(c2148918.sptg)
	e2:SetOperation(c2148918.spop)
	c:RegisterEffect(e2)
end
c2148918.listed_series={0x2b}
function c2148918.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local res,teg,tep,tev,tre,tr,trp=Duel.CheckEvent(EVENT_SPSUMMON_SUCCESS,true)
	if res and c2148918.spcon(e,tp,teg,tep,tev,tre,tr,trp) and c2148918.sptg(e,tp,teg,tep,tev,tre,tr,trp,0) and Duel.SelectYesNo(tp,94) then
		e:SetCategory(CATEGORY_ATKCHANGE)
		e:SetOperation(c2148918.spop2(e,tp,teg,tep,tev,tre,tr,trp))
		c2148918.sptg(e,tp,teg,tep,tev,tre,tr,trp,1)
	else
		e:SetCategory(0)
		e:SetOperation(nil)
	end
end
function c2148918.tgfilter(c,e,tp)
	return c:IsFaceup() and c:IsControler(tp) and (not e or c:IsRelateToEffect(e))
end
function c2148918.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c2148918.tgfilter,1,nil,nil,1-tp) and Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsSetCard,0x2b),tp,LOCATION_MZONE,0,1,nil)
end
function c2148918.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(eg)
end
function c2148918.spop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=eg:Filter(c2148918.tgfilter,nil,e,1-tp)
	local tc=g:GetFirst()
	for tc in aux.Next(g) do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(tc:GetAttack()/2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
function c2148918.spop2(e,tp,eg,ep,ev,re,r,rp)
	return function()
		c2148918.spop(e,tp,eg,ep,ev,re,r,rp)
	end
end