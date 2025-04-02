--ヘルカイザー・ドラゴン
--Chthonian Emperor Dragon
function c95888876.initial_effect(c)
	Gemini.AddProcedure(c)
	--Can attack twice
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetCondition(Gemini.EffectStatusCondition)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end